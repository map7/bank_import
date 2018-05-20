import { Controller } from "stimulus"
import Chartkick from "chartkick"
import Chart from "chart.js"

export default class extends Controller {
  initialize() {
    
    new Chartkick.PieChart("chart-1", [["Blueberry", 44], ["Strawberry", 23]])    
  }

  file() {
    console.log(this.targets.find("file_paths").value)
  }
}
