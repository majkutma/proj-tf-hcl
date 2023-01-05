import _ from 'lodash'

/**
 * Function creates simple message based on the parameter
 */
export const createMessage = (param: string): string => {
  const parmUpper: string = _.upperCase(param)
  const message = `This is my parameter in uppercase: ${parmUpper}`
  return message
}
