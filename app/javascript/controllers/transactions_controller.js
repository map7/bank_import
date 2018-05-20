import { Controller } from "stimulus"
import Chartkick from "chartkick"
import Chart from "chart.js"

export default class extends Controller {
  initialize() {
    fetch(this.data.get("url"))
      .then(response =>
            response.text())
      .then(expenses => {
        new Chartkick.PieChart("chart-1", JSON.parse(expenses))
      })

    
  }

  file() {
    console.log(this.targets.find("file_paths").value)
  }
}
