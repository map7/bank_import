import { Controller } from "stimulus"
import Chartkick from "chartkick"
import Chart from "chart.js"

export default class extends Controller {
  initialize() {
    // new Chartkick.PieChart("chart-1", [["Blueberry", 44], ["Strawberry", 23]])
    //new Chartkick.PieChart("chart-1", [["Transport", -16, 0], ["Car Expenses", -999, 0], ["Entertainment", -45, 0], ["Technology", -253, 0], ["Bank Fees", -86, 0], ["Insurance", -700, 100], ["paypal", -699, 0], ["Holiday", -710, 0], ["Alcohol", -166, 0], ["Pub", -338, 0], ["Pharmacy", -38, 0], ["Food", -1349, 0], ["Water", -63, 0], ["Internet", -80, 0], ["Electricity", -754, 0], ["Health", -305, 0]])

    fetch(this.data.get("url"))
      .then(response =>
            response.text())
      .then(expenses => {
        // console.log(expenses)
        new Chartkick.PieChart("chart-1", JSON.parse(expenses))
      })

    
  }

  file() {
    console.log(this.targets.find("file_paths").value)
  }
}
