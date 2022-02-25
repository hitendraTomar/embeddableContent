publisher = Publisher.create!(name: 'Test Publisher', email: 'testpublisher@yopmail.com', password: 'password', password_confirmation: 'password')

creator = Creator.create!(name: 'Test Creator', email: 'testcreator@yopmail.com', password: 'password', password_confirmation: 'password')

content = EmbeddableContent.find_or_create_by(title: 'My first book',header: "That's a header by creator", body: 'creator is creative and impressive', footer: "That's a footer by creator", user_id: creator.id)
content.content_stylesheets.find_or_create_by(name: "color", body: "color: blue;", user_id: creator.id)

content = EmbeddableContent.find_or_create_by(title: 'My second book',header: "That's a header by creator", body: 'creator is very creative and impressive', footer: "That's a footer by creator", user_id: creator.id)
content.content_stylesheets.find_or_create_by(name: "color", body: "color: black;", user_id: creator.id)

content_publisher = content.content_publishers.find_or_create_by(header: 'publisher changed the header to this', footer: 'publisher changed the footer to this', publisher: publisher)

content.content_stylesheets.find_or_create_by(name: "color", body: "color: yellow", user_id: publisher.id)

