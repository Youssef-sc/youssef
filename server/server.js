const express = require('express');
const bodyParser = require('body-parser');
const { spawn } = require('child_process');

const app = express();
app.use(bodyParser.json());

app.post('/analyze', (req, res) => {
    const data = JSON.stringify(req.body);

    const pythonProcess = spawn('python', ['python/model.py', data]);

    pythonProcess.stdout.on('data', (data) => {
        res.send(data.toString());
    });

    pythonProcess.stderr.on('data', (data) => {
        console.error(`stderr: ${data}`);
    });
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
