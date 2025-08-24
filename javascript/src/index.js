const fs = require('fs');
const path = require('path');

function promptRoulette() {
    try {
        const statementsPath = path.join(__dirname, '..', '..', 'statements.json');
        const statements = JSON.parse(fs.readFileSync(statementsPath, 'utf8'));
        
        if (Math.floor(Math.random() * 100) + 1 === 1) {
            return statements[Math.floor(Math.random() * statements.length)];
        }
        return "";
    } catch (error) {
        return "";
    }
}

module.exports = promptRoulette;