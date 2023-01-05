"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createMessage = void 0;
const lodash_1 = __importDefault(require("lodash"));
/**
 * Function creates simple message based on the parameter
 */
const createMessage = (param) => {
    const parmUpper = lodash_1.default.upperCase(param);
    const message = `This is my parameter in uppercase: ${parmUpper}`;
    return message;
};
exports.createMessage = createMessage;
