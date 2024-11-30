# QuickTube.app

<img src="shot.png">

<p align="center">
  <a href="https://quicktube.app/" _target="blank">quicktube.app</a>
</p>

<p align="center">Convert YouTube videos to MP3. No BS.</p>

<hr>

<div align="center">
  💎 Ruby 3.3 · 🛤 Rails 8 · ⚡️ Stimulus · 🅺 Kamal 2
</div>

<hr>

# Deploy

> [!NOTE]
> For Kamal v1 with Traefik, see [legacy v0.1.7.1](https://github.com/vladyio/quicktube/tree/v0.1.7.1).

1. Clone the repository
2. Install `kamal` (see [Kamal docs](https://kamal-deploy.org/docs/installation/)):

    `gem install kamal`
3. Create a `config/deploy.yml` file from sample:

    `cp config/deploy.yml.sample config/deploy.yml`
4. Set values in `config/deploy.yml` to match your setup
5. Create a `.kamal/secrets` file from sample:

    `cp .kamal/secrets.sample .kamal/secrets`
6. Set values in `.kamal/secrets` to match your setup
7. Prepare server(s) - everything from copying an SSH key to setting up UFW, users and permissions:

   ```
   ./bin/prepare_server
   ```
8. Finally, deploy:

   ```
   kamal accessory boot redis
   kamal deploy
   ```

## Custom environments

It's possible to prepare & deploy a custom environment too.

Make sure you have a `config/deploy.[environment].yml` and `.kamal/secrets.[environment]` files.

For example, for a `staging` environment:

    ./bin/prepare_server staging

    kamal accessory boot redis -d staging
    kamal deploy -d staging.

