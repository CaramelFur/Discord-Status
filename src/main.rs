use std::env;

use serenity::async_trait;
use serenity::gateway::ActivityData;
use serenity::model::gateway::Ready;
use serenity::prelude::*;

struct Handler;

#[async_trait]
impl EventHandler for Handler {
    async fn ready(&self, context: Context, ready: Ready) {
        let message = env::var("DISCORD_MESSAGE").unwrap_or_else(|_| "hello".to_string());

        context.set_activity(Some(ActivityData::playing(message)));

        if let Some(shard) = ready.shard {
            println!(
                "{} is connected on shard {}/{}!",
                ready.user.name,
                shard.id.0 + 1,
                shard.total,
            );
        }
    }
}

#[tokio::main]
async fn main() {
    let token = env::var("DISCORD_KEY").expect("Expected a token in the environment");

    let intents = GatewayIntents::empty();
    let mut client = Client::builder(token, intents)
        .event_handler(Handler)
        .await
        .expect("Error creating client");

    println!("Created client");

    if let Err(why) = client.start_autosharded().await {
        println!("Client error: {:?}", why);
    }
}
