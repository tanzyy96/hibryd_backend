ALTER TABLE "user" ALTER COLUMN qotw SET NOT NULL;
ALTER TABLE "user" DROP COLUMN profile_pic_s3_key;

ALTER TABLE "event" ALTER COLUMN description SET NOT NULL;

ALTER TABLE "message" ALTER COLUMN text SET NOT NULL;
ALTER TABLE "message" RENAME TO "messages";

