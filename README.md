# homebrew-tap

Personal Homebrew tap for custom and forked builds.

## Install from this tap

```bash
brew tap yofriadi/tap
brew install yofriadi/tap/tree
brew install yofriadi/tap/weathr
brew install yofriadi/tap/ticgit
brew install yofriadi/tap/uteke
```

- `ticgit` installs as `ti`

---

## PR Bottle Publish Flow (`pr-pull`) — Step by Step

Use this when publishing bottles from a **Pull Request** (or when re-running publish manually for a PR).

### 1) Create a branch and update formula

```bash
git checkout -b weathr-1.3.1
# edit Formula/*.rb
git add Formula/weathr.rb
git commit -m "weathr: bump to 1.3.1"
git push -u origin weathr-1.3.1
```

### 2) Open a Pull Request

Open PR to `master`.

### 3) Wait for `Tap Homebrew CI`

The workflow `.github/workflows/tests.yml` runs on PR.

What it does:
- syntax checks
- formula build/test (`brew test-bot`)
- uploads bottle artifacts (macOS job)

### 4) Let `brew publish` run `pr-pull`

After PR CI is successful, `.github/workflows/publish.yml` is triggered by `workflow_run` and runs:

```bash
brew pr-pull <PR_NUMBER> --tap=yofriadi/tap
```

This applies bottle changes and publishes bottles using the repo token.

### 5) Verify bottle commit landed on `master`

Check:
- Actions run is green (`brew publish`)
- formula contains updated `bottle do` block (if generated)
- related release assets/bottle URLs are available

### 6) Merge PR (if not already merged by your flow)

Follow your normal merge process.

---

## Manual re-run of `pr-pull`

If publish failed or needs repair:

1. Go to **Actions** → `brew publish`
2. Click **Run workflow**
3. Provide `pr_number` (number or full PR URL)
4. Run

The workflow will normalize the PR number and run `brew pr-pull` again.

---

## Notes

- Primary branch is `master`.
- Publish is CI-gated: expected order is `push/PR` → `Tap Homebrew CI` → `brew publish`.
- Publish uses PR-style flow only (`pr-pull`); there is no direct `push-publish` path.
