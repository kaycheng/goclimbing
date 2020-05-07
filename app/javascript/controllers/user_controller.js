import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "followButton" ]

  follow(event) {
    event.preventDefault()
    console.log("hello world")
  }
}
