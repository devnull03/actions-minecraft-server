# Minecraft Server on GitHub Actions

This project allows you to run a public Minecraft server on GitHub Actions using Playit.gg for tunneling. The server runs for free on GitHub's infrastructure and provides a permanent public address that players can connect to without installing any additional software.

This repository is forked from [AdamRaichu/actions-minecraft-server](https://github.com/AdamRaichu/actions-minecraft-server). The key improvement is replacing remote.it with Playit.gg, which eliminates the requirement for players to install client software. Players can connect directly using a standard Minecraft client.

## Why Playit.gg?

I initially tried using Cloudflare Tunnel for this project, but Cloudflare requires players to either use Cloudflare Spectrum (paid service starting at $20/month) or have clients run `cloudflared access tcp` locally, which defeats the purpose of a public server. Playit.gg provides true public access without any client-side software requirements.

## Setup Instructions

### Fork and Initial Configuration

1. Fork this repository to your GitHub account
2. The forked repository will be used to store your server files and world data

### Setting Up Playit.gg

1. Visit https://playit.gg/ and create an account
2. Navigate to https://playit.gg/account/agents
3. Click "Add Agent" and give it a name like "GitHub Actions Minecraft"
4. Copy the secret key (format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)
5. In your GitHub repository, go to Settings → Secrets and variables → Actions
6. Click "New repository secret"
7. Name: `PLAYIT_SECRET`
8. Value: Paste your Playit.gg secret key
9. Click "Add secret"

### Initial Server Setup

1. Go to the Actions tab in your repository
2. Select the "Setup Server" workflow
3. Click "Run workflow"
4. Check the box to agree to the Minecraft EULA
5. Optionally customize the server MOTD
6. Click "Run workflow"

This generates all necessary server files and creates the initial world.

### Configuring the Tunnel

1. After setup completes, visit https://playit.gg/account/tunnels
2. When your server runs, you'll see your agent online
3. Click "Add Tunnel"
4. Configure the tunnel:
   - Tunnel Type: `TCP`
   - Local Port: `25565`
   - Local Address: `127.0.0.1`
5. Click "Add"

You'll receive a permanent address like `your-server.joinmc.link` or `some-name.playit.gg:12345`. This address never changes and can be shared with players.

### Starting the Server

1. Go to the Actions tab
2. Select "Server Run" workflow
3. Click "Run workflow"
4. Optionally enable `should_add_op` and provide a Minecraft username to make them an operator
5. The server runs for up to 320 minutes (5+ hours) before stopping

### Connecting

Players connect using the permanent Playit.gg address in their Minecraft multiplayer server list. No additional software needed.

## Server Management

**World Saving**: Your world data, player progress, server settings, and operator lists are automatically saved to the GitHub repository when the server stops. This means your progress is preserved between sessions and the world will load exactly as you left it when you restart the server.

**Adding Operators**: Enable `should_add_op` when starting the workflow and provide the player's Minecraft username.

**Server Configuration**: Edit `server.properties` in the repository to customize game mode, difficulty, max players, and other settings.

**Monitoring**: View real-time server logs in the Actions tab under the running workflow.

## Troubleshooting

**Players can't connect**: Verify the Playit.gg agent shows as online at https://playit.gg/account/tunnels. Confirm the tunnel is configured for port 25565 and the workflow is still running. Double-check players are using the correct address from Playit.gg.

**Server won't start**: Check workflow logs for errors. Verify you agreed to the EULA and that `PLAYIT_SECRET` is correctly set in repository secrets.

**Tunnel not connecting**: Confirm `PLAYIT_SECRET` matches your Playit.gg secret key. Check for errors in the "Run Playit.gg Tunnel" workflow step.

## Credits

Original repository by [AdamRaichu](https://github.com/AdamRaichu/actions-minecraft-server). Modified to use Playit.gg instead of remote.it for public access. Cloudflare Tunnel was initially attempted but required paid services or client software, so Playit.gg was chosen as a free alternative.