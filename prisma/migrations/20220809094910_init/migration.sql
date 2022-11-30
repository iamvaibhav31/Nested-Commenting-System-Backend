/*
  Warnings:

  - You are about to drop the column `postsId` on the `comments` table. All the data in the column will be lost.
  - You are about to drop the column `usersId` on the `comments` table. All the data in the column will be lost.
  - The primary key for the `like` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `commentsId` on the `like` table. All the data in the column will be lost.
  - You are about to drop the column `usersId` on the `like` table. All the data in the column will be lost.
  - Added the required column `postId` to the `comments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `comments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `commentId` to the `like` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `like` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "comments" DROP CONSTRAINT "comments_postsId_fkey";

-- DropForeignKey
ALTER TABLE "comments" DROP CONSTRAINT "comments_usersId_fkey";

-- DropForeignKey
ALTER TABLE "like" DROP CONSTRAINT "like_commentsId_fkey";

-- DropForeignKey
ALTER TABLE "like" DROP CONSTRAINT "like_usersId_fkey";

-- AlterTable
ALTER TABLE "comments" DROP COLUMN "postsId",
DROP COLUMN "usersId",
ADD COLUMN     "postId" TEXT NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "like" DROP CONSTRAINT "like_pkey",
DROP COLUMN "commentsId",
DROP COLUMN "usersId",
ADD COLUMN     "commentId" TEXT NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL,
ADD CONSTRAINT "like_pkey" PRIMARY KEY ("userId", "commentId");

-- AddForeignKey
ALTER TABLE "comments" ADD CONSTRAINT "comments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comments" ADD CONSTRAINT "comments_postId_fkey" FOREIGN KEY ("postId") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "like" ADD CONSTRAINT "like_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "like" ADD CONSTRAINT "like_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "comments"("id") ON DELETE CASCADE ON UPDATE CASCADE;
