CREATE TABLE users (
	"id" serial NOT NULL,
	"name" varchar(110) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
);

CREATE TABLE tokens(
	"id" serial NOT NULL,
	"token" TEXT NOT NULL,
	"userId" integer NOT NULL,
	"expireAt" TIMESTAMP NOT NULL,
	CONSTRAINT "tokens_pk" PRIMARY KEY ("id")
);

ALTER TABLE "tokens" ADD CONSTRAINT "tokens_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id");

CREATE TABLE "shortUrl" (
	"id" serial NOT NULL,
	"url" TEXT NOT NULL,
	"key" TEXT NOT NULL,
	CONSTRAINT "shortUrl_pk" PRIMARY KEY ("id")
);
















