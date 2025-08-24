import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

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

export default promptRoulette;