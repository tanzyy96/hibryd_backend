CREATE SEQUENCE channel_id_seq;
CREATE SEQUENCE company_id_seq;
CREATE SEQUENCE day_status_id_seq;
CREATE SEQUENCE day_tasks_id_seq;
CREATE SEQUENCE event_id_seq;
CREATE SEQUENCE event_image_id_seq;
CREATE SEQUENCE message_id_seq;
CREATE SEQUENCE poll_id_seq;
CREATE SEQUENCE poll_option_id_seq;
CREATE SEQUENCE poll_option_vote_id_seq;
CREATE SEQUENCE task_id_seq;


ALTER TABLE "channel" ALTER COLUMN "id" SET DEFAULT nextval('channel_id_seq');
ALTER TABLE "company" ALTER COLUMN "id" SET DEFAULT nextval('company_id_seq');
ALTER TABLE "day_status" ALTER COLUMN "id" SET DEFAULT nextval('day_status_id_seq');
ALTER TABLE "day_tasks" ALTER COLUMN "id" SET DEFAULT nextval('day_tasks_id_seq');
ALTER TABLE "event" ALTER COLUMN "id" SET DEFAULT nextval('event_id_seq');
ALTER TABLE "event_image" ALTER COLUMN "id" SET DEFAULT nextval('event_image_id_seq');
ALTER TABLE "message" ALTER COLUMN "id" SET DEFAULT nextval('message_id_seq');
ALTER TABLE "poll" ALTER COLUMN "id" SET DEFAULT nextval('poll_id_seq');
ALTER TABLE "poll_option" ALTER COLUMN "id" SET DEFAULT nextval('poll_option_id_seq');
ALTER TABLE "poll_option_vote" ALTER COLUMN "id" SET DEFAULT nextval('poll_option_vote_id_seq');
ALTER TABLE "task" ALTER COLUMN "id" SET DEFAULT nextval('task_id_seq');