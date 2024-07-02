# QuickTube.app

<img src="shot.png">

<p align="center">
  <a href="https://quicktube.app/" _target="blank">quicktube.app</a>
</p>

<p align="center">Convert YouTube videos to MP3. No BS.</p>

<hr>

<div align="center">
  💎 Ruby 3.3 · 🛤 Rails 7.1 · ⚡️ Stimulus · 🅺 Kamal
</div>

<hr>

# Deploy

0. Clone the repository
1. Install `kamal` (see [Kamal docs](https://kamal-deploy.org/docs/installation/)):

    `gem install kamal`
2. Create a `deploy/config.yml` file from sample:

    `cp deploy/config.yml.sample deploy/config.yml`
3. Change `deploy/config.yml` to suit your needs
4. Create a `.env` file from sample:

    `cp .env.sample .env`
5. Change `.env` to suit your needs
6. Initialize the deployment:

   ```
   kamal setup
   kamal deploy
   kamal accessories boot redis
   ```
