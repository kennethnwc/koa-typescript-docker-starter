import Koa from "koa";

export const app = new Koa();

app.use(async (ctx) => {
  ctx.body = "Hello World!";
});

app.listen(4500, () => {
  console.log("listening on 4500");
});
