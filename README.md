# Student Project Submissions

This repository contains student self-picked assignment submissions for Big data course.

## 📝 Submission Guidelines

### Getting Started

1. **Read SECURITY.md first** - This is mandatory before making any commits
2. Copy the template from `templates/submission-template/`
3. Create your submission folder using the format: `topic-name`
4. Follow the folder structure provided in the template

### Folder Naming Convention

Use the format: `topic-name` where:
- `topic-name` is a brief description of your project (use hyphens, lowercase)
- place your submission in the `submissions/` directory
- please make sure the name is unique (ideally maps to workshop title) and descriptive


**Examples:**
- `submissions/sentiment-analysis`
- `submissions/chatbot-assistant`
- `submissions/image-classifier`
- `submissions/data-visualization`

### Required Submission Structure

Please refer to readme_template.md for detailed structure.


### File Size Guidelines

- **Presentations**: Keep under 20MB
- **Code files**: No size limit for text-based code
- **Data files**: Maximum 5MB per file
- **Videos**: Upload to YouTube/Drive and include links only
- **Large models**: Provide download instructions, don't commit the files

### Data Privacy Requirements

If your project uses data:

1. **Use only public datasets** or generate synthetic data
2. **Anonymize any personal information**
3. **Document data sources** in your README
4. **Do not include**:
   - Real user data
   - Personal identifiable information (PII)
   - Proprietary data without permission
   - Medical or financial records

### Pre-Submission Checklist

Before committing your work:

- [ ] I have read SECURITY.md thoroughly
- [ ] No API keys, passwords, or tokens in my code
- [ ] No personal contact information included
- [ ] All screenshots reviewed (no sensitive data visible)
- [ ] Data is anonymized, synthetic, or publicly available
- [ ] `.env` files are in `.gitignore`
- [ ] Large files handled appropriately
- [ ] My README explains how to run the project
- [ ] All dependencies are documented
- [ ] Code is commented and readable

## 🚀 How to Submit

### First Time Setup

```bash
# Clone the repository
git clone <repository-url>
cd project-repo

# Create a new branch for your work
git checkout -b topic-name-XXX

# Copy the template
cp -r templates/submission-template submissions/topic-name-XXX
cd submissions/topic-name-XXX
```

### Making Your Submission

```bash
# Add your files
git add .

# Check what you're committing (IMPORTANT!)
git status
git diff --cached

# Commit your changes
git commit -m "Add topic-name submission"

# Push your branch
git push origin topic-name-XXX
```

### Creating a Pull Request

1. Go to the repository on GitHub/GitLab
2. Click "New Pull Request"
3. Select your branch (`topic-name-XXX`)
4. Add a description of your project
5. Submit the pull request for review

## 📄 License

All submissions are licensed under MIT License- see LICENSE file for details.

---

**Remember**: Quality over quantity. A well-documented, working project is better than a complex but broken one. Good luck! 🎓