import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"
// Connects to data-controller="tom-select"
export default class extends Controller {
  connect() {
    const select = new TomSelect(this.element, {
      create: true,
      sortField: {
        field: "text",
        direction: "asc"
      }
    })
  const arrow = document.querySelector(".ts-wrapper")
  arrow.style.backgroundImage = "none";

  arrow.style.paddingRight = "12px"
  }
}
