"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createMessage = void 0;
/**
 * Function creates simple message based on the parameter
 */
const createMessage = (param) => {
    const message = `This is my parameter: ${param}`;
    return message;
};
exports.createMessage = createMessage;
