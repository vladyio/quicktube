import { Controller } from '@hotwired/stimulus'
import { createConsumer } from '@rails/actioncable'

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.consumer = createConsumer()
  }

  async start(event) {
    const { link } = event.detail;

    try {
      await this.fetch(link);
    } catch (error) {
      document.querySelector('#error-container').innerHTML = error.message;
    }
  }

  async fetch(link) {
    this.dispatch('loading');

    try {
      const response = await fetch(`${this.urlValue}?link=${encodeURIComponent(link)}`);

      if (!response.ok) {
        const { message } = await response.json();
        throw new Error(message);
      }

      const { jid } = await response.json();
      this.createSubscription(jid);
    } catch (error) {
      this.dispatch('stopLoading');
      document.querySelector('#error-container').innerHTML = error.message;
    }
  }

  createSubscription(jid) {
    this.subscription = this.consumer.subscriptions.create(
      { channel: 'DownloadChannel', jid: jid },
      {
        received: this.handleReceived.bind(this)
      }
    )
  }

  handleReceived(data) {
    const { status, message } = data

    if (status === 'complete') {
      this.saveFile(message)
      this.dispatch('complete')
    } else {
      document.querySelector('#error-container').innerHTML = message
    }

    this.dispatch('stopLoading', { detail: data })
  }

  saveFile(path) {
    const downloadLink = document.querySelector('#download-link')
    downloadLink.href = `/${path}`
    downloadLink.click()
  }

  disconnect() {
    if (this.subscription) {
      this.consumer.subscriptions.remove(this.subscription)
    }
    this.element.removeEventListener('jidReceived', this.handleJidReceived.bind(this))
  }
}
