"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.lambdaHandler = void 0;
const biz_utils_1 = require("./biz-utils");
/**
* Function returns message based on the event
 */
const lambdaHandler = async (event) => {
    try {
        console.log('The new event was created: ', event);
        const message = (0, biz_utils_1.createMessage)(event.pathParameters.proxy);
        return message;
    }
    catch (err) {
        const errString = JSON.stringify(err);
        return `An error occured: ${errString}`;
    }
};
exports.lambdaHandler = lambdaHandler;
