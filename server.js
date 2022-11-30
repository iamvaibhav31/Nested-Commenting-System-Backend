import fastify from "fastify";
import sensible from "@fastify/sensible"
import cors from "@fastify/cors"
import { PrismaClient } from "@prisma/client"
import dotenv from "dotenv"
dotenv.config()

const app = fastify()

app.register(sensible)

app.register(cors, {
     origin: true,
     credentials: true,
})
const prisma = new PrismaClient()


async function CommitToDB(promise) {
     const [error, data] = await app.to(promise)
     if (error) {
          return app.httpErrors.internalServerError(error.message)
     } else {
          return data
     }
}

app.get("/posts", async (req, res) => {
     return await CommitToDB(
          prisma.posts.findMany({
               select: {
                    id: true,
                    title: true,
               },
          })
     )
})

app.get("/posts/:id", async (req, res) => {
     return await CommitToDB(
          prisma.posts.findUnique({
               where: {
                    id: req.params.id
               }, select: {
                    title: true,
                    body: true,
                    comments: {
                         orderBy: {
                              createdAt: "desc"
                         }, select: {
                              id: true,
                              message: true,
                              parentId: true,
                              createdAt: true,
                              user: {
                                   select: {
                                        id: true,
                                        name: true,
                                   },
                              }
                         },

                    }
               },
          })
     )
})



app.listen({ port: process.env.PORT }, function (err, address) {
     if (err) {
          fastify.log.error(err)
          process.exit(1)
     } else {
          console.log("Server is now listening on ", address)
     }

})