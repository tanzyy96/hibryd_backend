ALTER TABLE "user" ALTER COLUMN qotw DROP NOT NULL;
ALTER TABLE "user" ADD COLUMN profile_pic_s3_key CHAR(255);

ALTER TABLE "event" ALTER COLUMN description DROP NOT NULL;

ALTER TABLE "messages" ALTER COLUMN text DROP NOT NULL;
ALTER TABLE "messages" RENAME TO "message";
