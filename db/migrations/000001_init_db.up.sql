CREATE TABLE IF NOT EXISTS "user"(
    "id" CHAR(255) NOT NULL,
    "username" CHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "birthdate" DATE NOT NULL,
    "qotw" CHAR(255) NOT NULL,
    "updated_at" DATE NOT NULL,
    "joined_at" DATE NOT NULL,
    "company_id" INTEGER NOT NULL
);
ALTER TABLE
    "user" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "user"."joined_at" IS 'company anniversary?';
CREATE TABLE IF NOT EXISTS "day_tasks"(
    "id" INTEGER NOT NULL,
    "user_id" CHAR(255) NOT NULL,
    "datetime" DATE NOT NULL
);
ALTER TABLE
    "day_tasks" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "task"(
    "id" INTEGER NOT NULL,
    "daytasks_id" INTEGER NOT NULL,
    "description" INTEGER NOT NULL,
    "status" INTEGER NOT NULL
);
ALTER TABLE
    "task" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "week_status"(
    "id" CHAR(255) NOT NULL,
    "user_id" CHAR(255) NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL
);
ALTER TABLE
    "week_status" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "event"(
    "id" INTEGER NOT NULL,
    "datetime" INTEGER NOT NULL,
    "name" CHAR(255) NOT NULL,
    "description" CHAR(255) NOT NULL
);
ALTER TABLE
    "event" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "day_status"(
    "id" INTEGER NOT NULL,
    "day_index" INTEGER NOT NULL,
    "date" DATE NOT NULL,
    "status" INTEGER NOT NULL,
    "week_status_id" CHAR(255) NOT NULL
);
ALTER TABLE
    "day_status" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "event_participants"(
    "user_id" CHAR(255) NOT NULL,
    "event_id" INTEGER NOT NULL,
    "is_participating" BOOLEAN NOT NULL
);
ALTER TABLE
    "event_participants" ADD CONSTRAINT "event_participants_user_id_unique" UNIQUE("user_id");
ALTER TABLE
    "event_participants" ADD CONSTRAINT "event_participants_event_id_unique" UNIQUE("event_id");
CREATE TABLE IF NOT EXISTS "company"(
    "id" INTEGER NOT NULL,
    "name" CHAR(255) NOT NULL
);
ALTER TABLE
    "company" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "channel"(
    "id" INTEGER NOT NULL,
    "type" INTEGER NOT NULL,
    "name" CHAR(255) NOT NULL,
    "expiry_date" DATE NULL
);
ALTER TABLE
    "channel" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "channel_participants"(
    "user_id" CHAR(255) NOT NULL,
    "channel_id" INTEGER NOT NULL
);
ALTER TABLE
    "channel_participants" ADD CONSTRAINT "channel_participants_user_id_unique" UNIQUE("user_id");
ALTER TABLE
    "channel_participants" ADD CONSTRAINT "channel_participants_channel_id_unique" UNIQUE("channel_id");
CREATE TABLE IF NOT EXISTS "messages"(
    "id" INTEGER NOT NULL,
    "sender_id" CHAR(255) NOT NULL,
    "text" CHAR(255) NOT NULL,
    "image_s3_key" CHAR(255) NULL,
    "reply_to" INTEGER NULL,
    "channel_id" INTEGER NOT NULL
);
ALTER TABLE
    "messages" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "messages"."reply_to" IS 'allow for reply to message_id';
CREATE TABLE IF NOT EXISTS "event_image"(
    "id" INTEGER NOT NULL,
    "image_s3_key" CHAR(255) NOT NULL,
    "loves" INTEGER NOT NULL,
    "comments" INTEGER NOT NULL,
    "event_id" INTEGER NOT NULL
);
ALTER TABLE
    "event_image" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "poll"(
    "id" INTEGER NOT NULL,
    "expiry_date" DATE NOT NULL,
    "channel_id" INTEGER NOT NULL
);
ALTER TABLE
    "poll" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "poll_option"(
    "id" INTEGER NOT NULL,
    "description" CHAR(255) NOT NULL,
    "added_by" CHAR(255) NOT NULL,
    "count" INTEGER NOT NULL,
    "poll_id" INTEGER NOT NULL
);
ALTER TABLE
    "poll_option" ADD PRIMARY KEY("id");
CREATE TABLE IF NOT EXISTS "poll_option_vote"(
    "id" INTEGER NOT NULL,
    "voted_by" CHAR(255) NOT NULL,
    "voted_at" DATE NOT NULL,
    "poll_option_id" INTEGER NOT NULL
);
ALTER TABLE
    "poll_option_vote" ADD PRIMARY KEY("id");
ALTER TABLE
    "day_tasks" ADD CONSTRAINT "day_tasks_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_company_id_foreign" FOREIGN KEY("company_id") REFERENCES "company"("id");
ALTER TABLE
    "task" ADD CONSTRAINT "task_daytasks_id_foreign" FOREIGN KEY("daytasks_id") REFERENCES "day_tasks"("id");
ALTER TABLE
    "week_status" ADD CONSTRAINT "week_status_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "day_status" ADD CONSTRAINT "day_status_week_status_id_foreign" FOREIGN KEY("week_status_id") REFERENCES "week_status"("id");
ALTER TABLE
    "event_participants" ADD CONSTRAINT "event_participants_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "event_participants" ADD CONSTRAINT "event_participants_event_id_foreign" FOREIGN KEY("event_id") REFERENCES "event"("id");
ALTER TABLE
    "messages" ADD CONSTRAINT "messages_channel_id_foreign" FOREIGN KEY("channel_id") REFERENCES "channel"("id");
ALTER TABLE
    "channel_participants" ADD CONSTRAINT "channel_participants_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "channel_participants" ADD CONSTRAINT "channel_participants_channel_id_foreign" FOREIGN KEY("channel_id") REFERENCES "channel"("id");
ALTER TABLE
    "event_image" ADD CONSTRAINT "event_image_event_id_foreign" FOREIGN KEY("event_id") REFERENCES "event"("id");
ALTER TABLE
    "poll" ADD CONSTRAINT "poll_channel_id_foreign" FOREIGN KEY("channel_id") REFERENCES "channel"("id");
ALTER TABLE
    "poll_option" ADD CONSTRAINT "poll_option_poll_id_foreign" FOREIGN KEY("poll_id") REFERENCES "poll"("id");
ALTER TABLE
    "poll_option_vote" ADD CONSTRAINT "poll_option_vote_poll_option_id_foreign" FOREIGN KEY("poll_option_id") REFERENCES "poll_option"("id");