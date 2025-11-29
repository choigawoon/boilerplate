# NPM Publishing Setup Guide

This document explains how to configure NPM publishing for this package.

## Overview

The package is configured to publish to two registries:

1. **GitHub Packages** (Always enabled - no setup required)
2. **NPM Public Registry** (Optional - requires NPM_TOKEN)

## GitHub Packages

GitHub Packages publishing is **automatically enabled** and requires no additional setup. It uses the `GITHUB_TOKEN` that GitHub Actions provides automatically.

- **Registry**: `https://npm.pkg.github.com`
- **Package URL**: `https://github.com/choigawoon/boilerplate/packages`
- **Authentication**: Automatic via `GITHUB_TOKEN`

### Installing from GitHub Packages

Users need to configure their `.npmrc`:

```bash
@choigawoon:registry=https://npm.pkg.github.com
```

Then install with:

```bash
npm install @choigawoon/boilerplate
```

## NPM Public Registry (Optional)

To publish to the public NPM registry, you need to configure an NPM access token.

### Step 1: Generate NPM Access Token

1. Log in to [npmjs.com](https://www.npmjs.com)
2. Go to **Account Settings** → **Access Tokens**
3. Click **Generate New Token** → **Granular Access Token**
4. Configure the token:
   - **Token Name**: `github-actions-boilerplate`
   - **Expiration**: Choose appropriate expiration (e.g., 90 days, 1 year, or no expiration)
   - **Packages and scopes**: Select your package scope (`@choigawoon`)
   - **Permissions**:
     - Read and write access to packages
5. Click **Generate Token**
6. **Copy the token immediately** (you won't be able to see it again)

### Step 2: Add Token to GitHub Secrets

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add the secret:
   - **Name**: `NPM_TOKEN`
   - **Value**: Paste the NPM access token you copied
5. Click **Add secret**

### Step 3: Verify Configuration

Once `NPM_TOKEN` is added, the workflow will:
- ✅ Detect the token exists
- ✅ Publish to NPM with provenance
- ✅ Display: "NPM_TOKEN is configured. Will publish to NPM."

If `NPM_TOKEN` is not configured:
- ⚠️ Skip NPM publishing
- ⚠️ Display: "NPM_TOKEN is not configured. Skipping NPM publish."
- ✅ Still publish to GitHub Packages

## Publishing a New Version

### Manual Release

1. Update version in `package.json`:
   ```bash
   npm version patch  # or minor, major
   ```

2. Push the tag:
   ```bash
   git push origin v0.0.2
   ```

3. GitHub Actions will automatically:
   - Run tests
   - Build the package
   - Publish to GitHub Packages (always)
   - Publish to NPM (if NPM_TOKEN exists)

### Automated Release (Future Enhancement)

Consider using tools like:
- **semantic-release**: Automated versioning and changelog
- **release-please**: Google's release automation tool

## Checking Publish Status

After pushing a tag, check the workflow status:

1. Go to **Actions** tab in your repository
2. Find the "Publish Package" workflow
3. Check the logs:
   - ✅ "NPM_TOKEN is configured" = Publishing to NPM
   - ⚠️ "NPM_TOKEN is not configured" = Skipping NPM (GitHub Packages only)

## Troubleshooting

### NPM Publish Fails

**Error: `E401 Unauthorized`**
- Token expired or invalid
- Regenerate NPM token and update GitHub secret

**Error: `E403 Forbidden`**
- Token doesn't have write permissions
- Check token scope includes your package

**Error: `E404 Package not found`**
- First time publishing: Go to npmjs.com and create the package manually
- Or use `npm publish` locally first

### GitHub Packages Publish Fails

**Error: `E401 Unauthorized`**
- Check workflow has `packages: write` permission (already configured)

**Error: `E404 or E403`**
- Check repository settings → Actions → General
- Ensure "Read and write permissions" is enabled

## Security Best Practices

1. **Use Granular Access Tokens**: Modern NPM tokens with limited scope
2. **Set Token Expiration**: Rotate tokens periodically
3. **Provenance Enabled**: Package includes build provenance metadata
4. **Don't Commit Tokens**: Never commit `.npmrc` with tokens to git

## Resources

- [NPM Access Tokens Documentation](https://docs.npmjs.com/creating-and-viewing-access-tokens)
- [GitHub Packages NPM Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-npm-registry)
- [NPM Provenance](https://docs.npmjs.com/generating-provenance-statements)
