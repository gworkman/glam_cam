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
  image = Req.get!("https://picsum.photos/400.jpg")
  GlamCam.Content.create_image!(image.body, :jpg)
end
