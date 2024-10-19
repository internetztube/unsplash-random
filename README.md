# Unsplash Random

An automated solution to fetch random photos from specific Unsplash users using GitHub Actions and Cloudflare Pages.

## Overview

With the discontinuation of [source.unsplash.com](https://source.unsplash.com/) in June 2024, accessing random photos from Unsplash contributors became challenging. This repository provides an alternative method to retrieve random images from your Unsplash portfolio, allowing you to showcase them on your website or GitHub profile.

Every hour, a GitHub Action fetches a random photo from the Unsplash API and generates a Cloudflare Pages redirect file, which is automatically deployed. This ensures that your displayed images are refreshed regularly without manual intervention.

## Example
![Random Unsplash Photo from @internetztube](https://unsplash.internetztube.net/internetztube/full)
https://unsplash.internetztube.net/internetztube/regular

## Prerequisites

- **Cloudflare Account**: [Sign up here](https://dash.cloudflare.com/sign-up)
- **Unsplash Account**: [Sign up here](https://unsplash.com/join)
- **GitHub Account**: [Sign up here](https://github.com/join)

## Installation

Follow the steps below to set up the project:

### 1. Create an Unsplash Demo Application

- Visit the [Unsplash Developer Applications](https://unsplash.com/oauth/applications) page.
- Click on **"New Application"** and provide the necessary details.
- After creation, note down your **Access Key** for later use.

### 2. Fork This Repository

- Click the **"Fork"** button in the top-right corner of this repository to create a copy under your GitHub account.

### 3. Enable GitHub Actions

- Navigate to your forked repository's **Settings**.
- In the sidebar, select **Actions** → **General**.
- Under **Workflow permissions**, ensure the following are enabled:
   - **Allow all actions and reusable workflows**
   - **Read repository contents and packages permissions**

### 4. Configure GitHub Secrets and Variables

- In your repository's **Settings**, go to **Secrets and variables** → **Actions**.
- Add the following:
   - **Secret**:
      - **Name**: `UNSPLASH_ACCESS_KEY`
      - **Value**: Your Unsplash Access Key from step 1.
   - **Variable**:
      - **Name**: `UNSPLASH_USERNAMES`
      - **Value**: Your Unsplash username(s). If multiple, enter one username per line.
   - **Optional Variable**:
      - **Name**: `FALLBACK_TARGET`
      - **Value**: A fallback URL for redirection in case of failure.

### 5. Set Up Cloudflare Pages

- Log in to your Cloudflare account and navigate to **Pages**.
- Click **"Create a project"** and select **"Connect to Git"**.
- Choose your forked GitHub repository.
- Configure the build settings:
   - **Framework preset**: Select **"None"**.
   - **Build command**: Leave empty.
   - **Build output directory**: Leave empty.
- Click **"Save and Deploy"**.
- **Note**: The initial deployment may fail due to the empty build directory. This is expected and will resolve after the first GitHub Action run.
- **Optional**: Add a custom domain by setting up a CNAME record pointing to your Cloudflare Pages domain.

### 6. Deployment

- The GitHub Action is scheduled to run hourly.
- It fetches a random image and updates the `_redirects` file.
- Cloudflare Pages automatically deploys the changes.


## Usage

Access the random image using the following URL structure:
```
https://<your-cloudflare-pages-domain>/<unsplash-username>/raw
https://<your-cloudflare-pages-domain>/<unsplash-username>/regular
https://<your-cloudflare-pages-domain>/<unsplash-username>/full
...
See _redirects file for all routes.
```