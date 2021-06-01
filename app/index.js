const express = require('express')

const app = express()

app.get('/', (req, res) => {
    res.send('sounds good')
})

const port = 6969
app.listen(port, () => {
    console.log(`listening on ${port}`)
})