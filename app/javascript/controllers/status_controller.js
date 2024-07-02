import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"]

  invalidLink() {
    this.textTarget.classList.remove("border-blue-500", "focus:ring-blue-500", "focus:border-blue-500")
    this.textTarget.classList.add("border-red-500", "focus:ring-red-500", "focus:border-red-500")
  }

  validLink() {
    this.textTarget.classList.remove("border-red-500", "focus:ring-red-500", "focus:border-red-500")
    this.textTarget.classList.add("border-blue-500", "focus:ring-blue-500", "focus:border-blue-500")
  }

  loading() {
    this.textTarget.classList.add("loader")
  }

  stopLoading() {
    this.textTarget.classList.remove("loader")
  }
}
