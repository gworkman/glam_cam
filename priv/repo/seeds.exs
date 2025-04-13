# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GlamCam.Repo.insert!(%GlamCam.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

for _ <- 1..10 do
  resp = Req.get!("https://picsum.photos/400.jpg")
  image = GlamCam.Content.new_post!(%{data: resp.body, type: :jpg})
end

captions = [
  "Innovation never sleeps—neither do we. 🚀",
  "Capturing moments, one frame at a time. 📸✨",
  "Behind every great project is a story worth telling. 🌟",
  "A snapshot of progress—because success looks this good. 🛠️",
  "From concept to creation, we’ve got the details covered. 🔧",
  "Another day, another breakthrough. 💡🌍",
  "Work hard, dream big, and don’t forget to pause for a photo. 🎯📷",
  "Proof that teamwork makes the dream work. 🤝📸",
  "Small steps lead to giant leaps. 🚶‍♂️✨",
  "Every pixel tells a part of the story. 🌌📷"
]

for caption <- captions do
  GlamCam.Content.new_caption!(caption)
  |> GlamCam.Content.approve_caption!()
end
