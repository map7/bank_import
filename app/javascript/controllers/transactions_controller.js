import { Controller } from "stimulus"

export default class extends Controller {
  log() {
    console.log(this.targets.find("hello").value)
  }
}
