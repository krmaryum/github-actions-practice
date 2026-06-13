# Disable `push` Trigger in GitHub Actions Workflows

## Complete Step-by-Step Study Notes

These notes explain how to disable the `push` trigger in multiple GitHub Actions `.yml` workflow files using the `sed` command.

This is useful when you want to keep workflows in your repository but prevent them from running automatically on every `git push`.

---

## 1. Situation

Repository path:

```bash
/c/Linux/github-actions-practice
```

You checked files:

```bash
ls
ls -al
```

You saw:

```text
.git/
.github/
README.md
```

The `.github` directory contains GitHub Actions configuration.

---

## 2. Go to Workflow Directory

```bash
cd .github
ls
cd workflows/
ls
```

Example workflow files:

```text
exclude-fail-fast.yml
extended-matrix.yml
github-hosted-runners.yml
hello.yml
manual.yml
matrix.yml
pr-check.yml
preinstalled-tools.yml
scheduled-trigger.yml
self-hosted-label.yml
self-hosted.yml
```

---

## 3. Original Trigger

Many workflow files have:

```yaml
on:
  push:
  workflow_dispatch:
```

Meaning:

| Trigger | Purpose |
|--------|---------|
| `push:` | Runs automatically when code is pushed |
| `workflow_dispatch:` | Allows manual run from GitHub Actions UI |

---

## 4. Goal

Disable only the `push:` trigger:

```yaml
on:
#   push:
  workflow_dispatch:
```

This means:

```text
Push trigger disabled
Manual trigger still enabled
```

---

## 5. Command Used

Run this inside `.github/workflows`:

```bash
sed -i '/^[[:space:]]*push:/s/^/# /' *.yml
```

---

## 6. Command Breakdown

| Part | Meaning |
|------|---------|
| `sed` | Stream editor |
| `-i` | Edit file in place |
| `/^[[:space:]]*push:/` | Find lines that start with spaces and then `push:` |
| `s/^/# /` | Add `# ` at the beginning of the line |
| `*.yml` | Apply to all `.yml` files |

---

## 7. What `[[:space:]]*` Means

```bash
[[:space:]]*
```

Means:

```text
Match zero or more spaces or tabs
```

So it matches:

```yaml
push:
```

```yaml
  push:
```

```yaml
    push:
```

---

## 8. Before and After

### Before

```yaml
name: Matrix Build

on:
  push:
  workflow_dispatch:
```

### After

```yaml
name: Matrix Build

on:
#   push:
  workflow_dispatch:
```

---

## 9. Check One File

```bash
cat matrix.yml
```

Example result:

```yaml
name: Matrix Build

on:
#   push:
  workflow_dispatch:

jobs:
  python-version-test:
    runs-on: ubuntu-latest
```

This confirms that `push:` was commented successfully.

---

## 10. What Happens Now?

After this change:

```text
git push will NOT trigger the workflow automatically.
```

But you can still run it manually:

```text
GitHub Repository
→ Actions
→ Select Workflow
→ Run workflow
```

---

## 11. Verify All Workflow Files

```bash
grep -n "push:" *.yml
```

Expected output:

```text
hello.yml:4:#   push:
matrix.yml:4:#   push:
manual.yml:4:#   push:
```

---

## 12. Check Git Changes

```bash
git status
git diff
```

---

## 13. Commit and Push

Go back to repo root:

```bash
cd ../..
```

Then:

```bash
git add .
git commit -m "Disable push trigger in workflows"
git push
```

---

## 14. Restore Push Trigger Later

Manual restore:

```yaml
#   push:
```

Change back to:

```yaml
  push:
```

Command restore method:

```bash
sed -i 's/^#   push:/  push:/' *.yml
```

Run this inside `.github/workflows`.

---

## 15. Cleaner YAML Style

Your current result:

```yaml
on:
#   push:
  workflow_dispatch:
```

Works fine.

Cleaner style:

```yaml
on:
  # push:
  workflow_dispatch:
```

Both disable the push trigger.

---

## 16. Alternative Method: Rename Files

You can disable workflows by renaming them:

```bash
mv matrix.yml matrix.yml.disabled
```

GitHub Actions only runs files ending in:

```text
.yml
.yaml
```

But for this case, commenting only `push:` is better because `workflow_dispatch:` stays active.

---

## 17. Full Practice Flow

```bash
cd /c/Linux/github-actions-practice

cd .github/workflows

ls

sed -i '/^[[:space:]]*push:/s/^/# /' *.yml

cat matrix.yml

grep -n "push:" *.yml

cd ../..

git status

git diff

git add .

git commit -m "Disable push trigger in workflows"

git push
```

---

## 18. Roman Urdu Explanation

`push:` GitHub Actions ka automatic trigger hota hai.

Jab aap code GitHub par push karte hain, workflow automatically run hota hai.

Aap ne `push:` ke start mein `#` laga diya:

```yaml
#   push:
```

Is ka matlab hai:

```text
Push trigger disabled
```

Lekin:

```yaml
workflow_dispatch:
```

abhi active hai.

Is ka matlab hai:

```text
Workflow manually run ho sakta hai GitHub Actions UI se.
```

---

## 19. Interview Question

### Question

How can you disable the `push` trigger in multiple GitHub Actions workflow files?

### Answer

Use `sed` to comment the `push:` line in all `.yml` workflow files:

```bash
sed -i '/^[[:space:]]*push:/s/^/# /' *.yml
```

This disables automatic workflow execution on push while keeping other triggers such as `workflow_dispatch` active.

---

## 20. Final Result

Before:

```yaml
on:
  push:
  workflow_dispatch:
```

After:

```yaml
on:
#   push:
  workflow_dispatch:
```

Final behavior:

| Action | Result |
|--------|--------|
| `git push` | Workflow will not run automatically |
| Manual Run button | Workflow can run manually |

---

## Conclusion

Using `sed` to comment `push:` is a fast and practical way to disable automatic GitHub Actions runs across multiple workflow files.

This is especially useful during GitHub Actions practice when you want to push code without triggering all workflows automatically.
