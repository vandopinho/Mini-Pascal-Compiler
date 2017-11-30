
package run;


import java.io.IOException;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import run.parser.GrammarLexer;
import run.parser.GrammarParser;
import run.parser.GrammarVisitor;
import run.util.GrammarVisitorImpl;

public class Run {

    public static void main(String[] args) throws IOException {
        ANTLRInputStream input = new ANTLRFileStream("input");
        GrammarLexer lexer = new GrammarLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        GrammarParser parser = new GrammarParser(tokens);
        
        ParseTree tree = parser.program();
        
        GrammarVisitor eval = new GrammarVisitorImpl();
        eval.visit(tree);

    }

}