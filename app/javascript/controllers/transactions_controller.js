import { Controller } from "stimulus"

export default class extends Controller {
  file() {
    console.log(this.targets.find("file_paths").value)
  }
}
