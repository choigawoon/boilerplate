# @choigawoon/boilerplate

NPM package boilerplate with TypeScript, tsup, and GitHub Actions auto-deploy.

## Features

- TypeScript support
- Fast builds with tsup (esbuild)
- Automatic NPM publishing via GitHub Actions
- CI/CD pipeline for PR validation
- Ready for AI agent collaboration

## Installation

```bash
npm install @choigawoon/boilerplate
```

## Usage

```typescript
import { hello } from '@choigawoon/boilerplate';

console.log(hello()); // "Hello, World!"
console.log(hello('Alice')); // "Hello, Alice!"
```

## Development

```bash
# Install dependencies
npm install

# Build
npm run build

# Watch mode
npm run dev

# Type check
npm run typecheck
```

## Publishing

This package automatically publishes to NPM when you push a git tag:

```bash
# Update version in package.json
npm version patch  # or minor, major

# Push the tag
git push origin v0.0.2
```

The GitHub Actions workflow will automatically:
1. Run type checking
2. Build the package
3. Publish to NPM

## Setup for Your Own Package

1. **Fork or copy this repository**

2. **Update package.json**:
   - Change `name` to your package name (e.g., `@yourname/package`)
   - Update `author`, `description`, `keywords`

3. **Add NPM token to GitHub Secrets**:
   - Create an NPM access token at https://www.npmjs.com/settings/YOUR_USERNAME/tokens
   - Add it to GitHub repository secrets as `NPM_TOKEN`

4. **Make changes and create PR**:
   - AI agents can create PRs with new features
   - CI workflow validates the changes automatically

5. **Merge PR and create release**:
   ```bash
   npm version patch
   git push origin v0.0.2
   ```

## AI Agent Workflow

This boilerplate is designed to work with AI agents:

1. AI agent creates a new branch
2. AI agent implements features
3. AI agent creates a PR
4. GitHub Actions runs CI tests
5. After PR merge, manually create a version tag
6. GitHub Actions automatically publishes to NPM

## Project Structure

```
.
├── src/
│   └── index.ts          # Main entry point
├── dist/                 # Build output (auto-generated)
├── .github/
│   └── workflows/
│       ├── ci.yml        # PR validation
│       └── publish.yml   # NPM publishing
├── package.json
├── tsconfig.json
├── tsup.config.ts
└── README.md
```

## License

MIT
