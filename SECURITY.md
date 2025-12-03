# Security Guidelines for Project Submissions

## 🚨 CRITICAL: What You Must NEVER Commit

### Credentials and Secrets
- **API Keys** (OpenAI, Google, AWS, Azure, etc.)
- **Passwords** of any kind
- **Database credentials** (username, password, connection strings)
- **Authentication tokens** (JWT, OAuth, Bearer tokens)
- **SSH keys or certificates**
- **Private keys** (.pem, .key, .pfx files)
- **Service account credentials**

### Personal Information
- Real email addresses
- Phone numbers
- Student ID numbers
- Home addresses
- Social security numbers or national IDs
- Credit card information
- Any personally identifiable information (PII)

### Sensitive Files
- Database dumps with real data
- Configuration files with hardcoded secrets
- `.env` files with actual credentials
- Backup files containing sensitive data
- Log files with authentication details

### Screenshots and Media
- Screenshots showing credentials in browser/terminal
- Screen recordings with API keys visible
- Images with personal information
- Videos containing sensitive data

## ✅ Safe Practices: What You SHOULD Do

### 1. Use Environment Variables
**Instead of this (WRONG):**
```python
api_key = "sk-abc123xyz789"
db_password = "MyPassword123"
```

**Do this (CORRECT):**
```python
import os
api_key = os.getenv('API_KEY')
db_password = os.getenv('DB_PASSWORD')
```

### 2. Provide Example Files
Create `.env.example` files:
```bash
# .env.example
API_KEY=your_api_key_here
DATABASE_URL=your_database_url_here
SECRET_KEY=your_secret_key_here
```

Then add `.env` to `.gitignore`

### 3. Use Placeholder Values
In documentation and code comments:
```python
# config.py
API_ENDPOINT = "https://api.example.com"
API_KEY = "YOUR_API_KEY_HERE"  # Replace with your actual key
```

### 4. Anonymize Data
If you must include data:
- Use synthetic/fake data
- Anonymize real data (remove names, emails, IDs)
- Use publicly available datasets only
- Document your data sources

### 5. Review Before Committing
Before running `git add`:
```bash
# Check what you're about to commit
git diff

# Search for common sensitive patterns
git diff | grep -i "password\|api_key\|secret\|token"
```

## 📋 Pre-Commit Checklist

Before submitting your work, verify:

- [ ] No API keys or tokens in code
- [ ] No passwords or credentials
- [ ] No personal contact information
- [ ] Screenshots reviewed (no sensitive data visible)
- [ ] Data is anonymized or synthetic
- [ ] `.env` files are in `.gitignore`
- [ ] Configuration files use placeholders
- [ ] README includes setup instructions with example values
- [ ] Large files handled appropriately (or linked externally)
- [ ] No database dumps with real data

## 🆘 If You Accidentally Commit Sensitive Data

### DO NOT:
- Simply delete the file in a new commit (it remains in git history!)
- Think that no one will notice
- Ignore the problem

### DO:
1. **Contact your instructor immediately**
2. **Stop pushing to the repository**
3. Notify them which file(s) contain sensitive data
4. If you exposed an API key, **revoke/rotate it immediately**

### Why This Matters:
Once something is committed to git, it exists in the repository history forever unless specifically removed. Even if you delete it in the next commit, anyone with access to the repo can see the old version.

## 🔒 Additional Security Tips

### For API Keys
- Use API key restrictions (IP whitelist, usage limits)
- Rotate keys regularly
- Never share keys via email, chat, or documents

### For Demos
- Use demo/sandbox accounts
- Create test databases with fake data
- Set up separate development environments

### For Presentations
- Blur or hide sensitive information in screenshots
- Use "Lorem Ipsum" or placeholder text
- Review slides before sharing

### For Data
- Check license/terms of use for datasets
- Prefer public, open datasets
- When in doubt, generate synthetic data

## 📚 Recommended Tools

- **git-secrets**: Prevents committing secrets
- **truffleHog**: Scans for secrets in git history
- **dotenv**: Manages environment variables
- **GitHub Secret Scanning**: Automatic detection (if using GitHub)

## 📞 Questions?

If you're unsure whether something is safe to commit:
- **Ask your instructor first**
- Err on the side of caution
- Better to ask than to expose sensitive data

---

**Remember**: Security is everyone's responsibility. Protecting sensitive information protects you, your classmates, and the institution.