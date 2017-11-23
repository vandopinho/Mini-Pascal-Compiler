
package basicintast;

import basicintast.parser.BasicLexer;
import basicintast.parser.BasicParser;
import basicintast.parser.BasicVisitor;
import basicintast.util.BasicVisitorImpl;
import java.io.IOException;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class Run {

    public static void main(String[] args) throws IOException {
        ANTLRInputStream input = new ANTLRFileStream("input.basic");
        BasicLexer lexer = new BasicLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        BasicParser parser = new BasicParser(tokens);

        ParseTree tree = parser.program();

        BasicVisitor eval = new BasicVisitorImpl();
        eval.visit(tree);
    }

}
