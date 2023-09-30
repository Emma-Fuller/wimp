import gleam/http
import gleam/http/request.{Request}
import gleam/uri.{Uri}
import gleam/json

// Message API Endpoints
const send_message_endpoint: String = "https://api.pushover.net/1/messages.json"
const get_sounds_list_endpoint: String = "https://api.pushover.net/1/sounds.json?token={TOKEN}"
const check_remaining_limit_endpoint: String = "https://api.pushover.net/1/apps/limits.json?token={TOKEN}"

// Validate user/group API Endpoint
const validate_user_endpoint: String = "https://api.pushover.net/1/users/validate.json"

// Receipts API Endpoint
const check_receipt_endpoint: String = "https://api.pushover.net/1/receipts/{RECEIPT}.json?token={TOKEN}"
const cancel_receipt_endpoint: String = "https://api.pushover.net/1/receipts/{RECEIPT}/cancel.json"
const cancel_receipts_by_tag_endpoint: String = "https://api.pushover.net/1/receipts/cancel_by_tag/{TAG}.json"

// Subscription API Endpoint
const migrate_user_to_subscription_endpoint: String = "https://api.pushover.net/1/subscriptions/migrate.json"

// Group API Endpoints
const check_group_info_endpoint: String = "https://api.pushover.net/1/groups/{GROUP}.json?token={TOKEN}"
const add_user_to_group_endpoint: String = "https://api.pushover.net/1/groups/{GROUP}/add_user.json?token={TOKEN}"
const remove_user_from_group_endpoint: String = "https://api.pushover.net/1/groups/{GROUP}/delete_user.json?token={TOKEN}"
const disable_user_in_group_endpoint: String = "https://api.pushover.net/1/groups/{GROUP}/disable_user.json?token={TOKEN}"
const enable_user_in_group_endpoint: String = "https://api.pushover.net/1/groups/{GROUP}/enable_user.json?token={TOKEN}"
const rename_group_endpoint: String = "https://api.pushover.net/1/groups/{GROUP}/rename.json?token={TOKEN}"

// Glances API Endpoint
const glances_endpoint: String = "https://api.pushover.net/1/glances.json"

// Licenses API Endpoint
const assign_license_endpoint: String = "https://api.pushover.net/1/licenses/assign.json"
const check_license_endpoint: String = "https://api.pushover.net/1/licenses.json?token={TOKEN}"

// Open Client API Endpoints
const login_user_endpoint: String = "https://api.pushover.net/1/users/login.json"
const register_device_endpoint: String = "https://api.pushover.net/1/devices.json"
const download_messages_endpoint: String = "https://api.pushover.net/1/messages.json"
const get_icon_endpoint: String = "https://api.pushover.net/icons/{ICON}.png"
const get_sound_endpoint: String = "https://api.pushover.net/sounds/{SOUND}.mp3"
const delete_messages_endpoint: String = "https://api.pushover.net/1/devices/{DEVICE}/update_highest_message.json"
const acknowledge_message_endpoint: String = "https://api.pushover.net/1/receipts/{RECEIPT}/acknowledge.json"

pub type Credentials() {
  Credentials(token: String, user: String)
}

fn encode_body(the_stuff: Credentials) -> String {
  json.object([
    #("token", json.string(the_stuff.token)),
    #("user", json.string(the_stuff.user)),
  ]) |> json.to_string
}

/// This is the main function you'll be using to create Request objects.
/// 
/// # Examples
/// 
///   > Credentials(user: "user123", token: "token123")    
///   > |> wimp.make_notification_request
pub fn make_notification_request(creds: Credentials) -> Request(String) {
  let assert Ok(req) = request.to("https://api.pushover.net/1/messages.json")
  let fields = creds |> encode_body

  req
    |> request.prepend_header("Content-Type", "application/json")
    |> request.set_method(http.Post)
    |> request.set_body(fields)
}
