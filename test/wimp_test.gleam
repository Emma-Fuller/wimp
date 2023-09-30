import wimp.{Credentials}
import gleam/result.{try}
import gleam/hackney
import gleam/io

/// You can do this!!
pub fn main() {
    let request = Credentials(token: "token123", user: "user123")
      |> wimp.make_notification_request
      |> hackney.send

    use res <- try(request)
    io.debug(res)

    Ok(Nil)
}
