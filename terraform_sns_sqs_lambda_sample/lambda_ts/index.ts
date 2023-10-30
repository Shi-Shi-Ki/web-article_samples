export const handler = async (event, context) => {
  event.Records.forEach((record) => {
    const { body } = record;
    console.log("body from sns-sqs.");
    console.log(body);
    const data = JSON.parse(body);
    console.log(`data.Message: ${data.Message}`);
  });
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "hello world",
    }),
  };
};
