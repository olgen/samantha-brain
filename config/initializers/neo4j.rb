neo_host = ENV['NEO4J_HOST'] or raise "NEO4J_HOST ENV var missing!"
neo_username = ENV['NEO4J_USERNAME'] or raise "NEO4J_USERNAME ENV var missing!"
neo_password = ENV['NEO4J_PASSWORD'] or raise "NEO4J_PASSWORD ENV var missing!"

Neo4j::Session.open(:server_db, neo_host,
                    { basic_auth: {
                      username: neo_username,
                      password: neo_password}
                    })
