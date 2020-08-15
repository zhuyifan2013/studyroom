function buildSuccessResponse(body) {
    return {code: 0, message: "success", data: body}
}

function buildErrorResponse(code = -1, message) {
    return {code: code, message: message, data: {}}
}

module.exports = {
    buildSuccessResponse,
    buildErrorResponse
}