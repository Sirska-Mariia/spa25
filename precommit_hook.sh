#!/bin/bash
# Pre-commit hook to prevent committing sensitive data
# Place this file in .git/hooks/pre-commit and make it executable:
# chmod +x .git/hooks/pre-commit

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "🔍 Running pre-commit security checks..."

# Check for common sensitive patterns in staged files
FORBIDDEN_PATTERNS=(
    "api[_-]?key"
    "apikey"
    "secret[_-]?key"
    "password"
    "passwd"
    "bearer"
    "token"
    "aws[_-]?access[_-]?key"
    "aws[_-]?secret"
    "private[_-]?key"
    "sk-[a-zA-Z0-9]{20,}"
    "AIza[0-9A-Za-z\\-_]{35}"
    "AKIA[0-9A-Z]{16}"
)

# Get list of staged files (only text files)
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -vE '\.(png|jpg|jpeg|gif|pdf|zip|tar|gz|mp4|mov|avi)$')

if [ -z "$STAGED_FILES" ]; then
    echo -e "${GREEN}✓ No text files to check${NC}"
    exit 0
fi

FOUND_ISSUES=0

# Check each pattern
for pattern in "${FORBIDDEN_PATTERNS[@]}"; do
    if git diff --cached | grep -iE "$pattern" > /dev/null; then
        if [ $FOUND_ISSUES -eq 0 ]; then
            echo -e "${RED}⚠️  WARNING: Possible sensitive data detected!${NC}"
            echo ""
        fi
        echo -e "${YELLOW}Found pattern: $pattern${NC}"
        FOUND_ISSUES=1
    fi
done

# Check for .env files
if echo "$STAGED_FILES" | grep -E '\.env$' > /dev/null; then
    echo -e "${RED}⚠️  WARNING: Attempting to commit .env file!${NC}"
    echo -e "${YELLOW}Real .env files should never be committed.${NC}"
    echo "Only .env.example files should be in the repository."
    FOUND_ISSUES=1
fi

# Check for common credential files
CREDENTIAL_FILES=(
    "credentials.json"
    "secrets.json"
    "config/credentials"
    "api_keys.txt"
    ".aws/credentials"
    "service-account"
)

for file_pattern in "${CREDENTIAL_FILES[@]}"; do
    if echo "$STAGED_FILES" | grep -i "$file_pattern" > /dev/null; then
        echo -e "${RED}⚠️  WARNING: Attempting to commit credential file: $file_pattern${NC}"
        FOUND_ISSUES=1
    fi
done

# Check for large files (>10MB)
for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        if [ "$size" -gt 10485760 ]; then
            echo -e "${YELLOW}⚠️  WARNING: Large file detected: $file ($(numfmt --to=iec-i --suffix=B $size))${NC}"
            echo "Consider using Git LFS or providing a download link instead."
            FOUND_ISSUES=1
        fi
    fi
done

# Check for common mistake: hardcoded IPs or localhost with credentials
if git diff --cached | grep -E "(http://|https://)([^:]+):([^@]+)@" > /dev/null; then
    echo -e "${RED}⚠️  WARNING: URL with embedded credentials detected!${NC}"
    echo "Example: https://user:password@domain.com"
    FOUND_ISSUES=1
fi

# If issues found, ask for confirmation
if [ $FOUND_ISSUES -eq 1 ]; then
    echo ""
    echo -e "${RED}================================${NC}"
    echo -e "${RED}   SECURITY CHECK FAILED!${NC}"
    echo -e "${RED}================================${NC}"
    echo ""
    echo "Your commit contains potentially sensitive information."
    echo ""
    echo "Please review your changes carefully:"
    echo "  git diff --cached"
    echo ""
    echo "If you're sure this is safe to commit, you can bypass this check with:"
    echo "  git commit --no-verify"
    echo ""
    echo -e "${YELLOW}However, it's recommended to remove sensitive data instead.${NC}"
    echo ""
    
    # In interactive mode, ask for confirmation
    if [ -t 0 ]; then
        read -p "Do you still want to commit? (type 'yes' to proceed): " response
        if [ "$response" != "yes" ]; then
            echo -e "${GREEN}Commit aborted. Please review and fix the issues.${NC}"
            exit 1
        else
            echo -e "${YELLOW}Proceeding with commit (use with caution)...${NC}"
            exit 0
        fi
    else
        # Non-interactive mode, just fail
        exit 1
    fi
else
    echo -e "${GREEN}✓ Security checks passed!${NC}"
    exit 0
fi