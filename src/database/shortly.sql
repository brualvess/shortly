CREATE TABLE users (
	"id" serial NOT NULL,
	"name" varchar(110) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
);




