import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { theme: { type: String, default: "classic" } }

  toggle() {
    const current = this.themeValue || "classic"
    const newTheme = current === "classic" ? "modern" : "classic"

    fetch(`/themes/${newTheme}`, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept": "application/json"
      }
    })
    .then(response => {
      if (!response.ok) { throw new Error("Bad response") }
      document.body.classList.remove(current)
      document.body.classList.add(newTheme)
      this.themeValue = newTheme
    })
    .catch(console.error)
  }
}
