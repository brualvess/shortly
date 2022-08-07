CREATE TABLE users (
	"id" serial NOT NULL,
	"name" varchar(110) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	"createdAt" TIMESTAMP NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
);


CREATE TABLE tokens (
	"id" serial NOT NULL,
	"token" TEXT NOT NULL,
	"userId" integer NOT NULL,
	"expireAt" TIMESTAMP NOT NULL,
	"createdAt" TIMESTAMP NOT NULL,
	CONSTRAINT "tokens_pk" PRIMARY KEY ("id")
);



CREATE TABLE "shortUrl" (
	"id" serial NOT NULL,
	"url" TEXT NOT NULL,
	"key" TEXT NOT NULL,
	"userId" bigint NOT NULL,
	"createdAt" TIMESTAMP NOT NULL,
	CONSTRAINT "shortUrl_pk" PRIMARY KEY ("id")
);



CREATE TABLE visits (
	"id" serial NOT NULL,
	"urlId" integer NOT NULL,
	"visitDate" TIMESTAMP NOT NULL,
	CONSTRAINT "visits_pk" PRIMARY KEY ("id")
);




ALTER TABLE "tokens" ADD CONSTRAINT "tokens_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id");

ALTER TABLE "shortUrl" ADD CONSTRAINT "shortUrl_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id");

ALTER TABLE "visits" ADD CONSTRAINT "visits_fk0" FOREIGN KEY ("urlId") REFERENCES "shortUrl"("id");




