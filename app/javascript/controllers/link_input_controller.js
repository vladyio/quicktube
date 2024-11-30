import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"]
  static YOUTUBE_LINK_REGEX = new RegExp(
    '^(https?:\\/\\/)?' +
    '(www\\.)?' +
    '(youtube\\.com|youtu\\.be|m\\.youtube\\.com|music\\.youtube\\.com|gaming\\.youtube\\.com)' +
    '\\/(watch\\?v=|embed\\/|v\\/|.+\\?v=|)?' +
    '([a-zA-Z0-9_-]{11})' +
    '(\\?feature=shared)?' +
    '(&.+)?$'
  )

  connect() {
    this.reset()
  }

  change() {
    const link = this.textTarget.value
    document.querySelector('#error-container').innerHTML = ''
    const validLink = this.validateLink(link)

    if (validLink) {
      this.dispatch('downloadStart', { detail: { link: link } })
    }
  }

  reset() {
    this.textTarget.value = ''
  }

  validateLink(link) {
    if (!link) {
      return false
    }

    if (!link.match(this.constructor.YOUTUBE_LINK_REGEX)) {
      this.dispatch('invalidLink')

      return false
    } else {
      this.dispatch('validLink')

      return true
    }
  }
}
