import { Controller } from "stimulus"
import axios from 'axios'

export default class extends Controller {
  static targets = ["followButton", "followerButton" ]

  follow(event) {
    event.preventDefault()
    let user = this.followButtonTarget.dataset.user
    let button = this.followButtonTarget

    axios.post(`users/${user}/follow`)
         .then(function(response) {
           let status = response.data.status
           switch(status){
             case 'Sign in first!!':
               alert('You need to login first！')
               break
             default:
              button.innerHTML = status
           }
         })
         .catch(function(error) {
           console.log(error)
         })
  }

  follower(event) {
    event.preventDefault()
    let username = this.followerButtonTarget.dataset.user
    let followButtonText = this.followButtonTarget.innerHTML
    let numFollowers = this.followerButtonTarget.innerHTML

    var num = (followButtonText == 'Followed') ? 'numFollowers - 1' : 'numFollowers + 1'
  }

}

  

