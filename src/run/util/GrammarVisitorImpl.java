
package run.util;

import run.parser.GrammarBaseVisitor;
import run.parser.GrammarLexer;
import run.parser.GrammarParser;
import java.util.Scanner;


public class GrammarVisitorImpl extends GrammarBaseVisitor<Object> {

    @Override
    public Object visitCondIf(GrammarParser.CondIfContext ctx) {
        Boolean cond = (Boolean) visit(ctx.condExpr());
        if (cond) {
            return visit(ctx.b1);
        }
        return null;
    }

    @Override 
    public Object visitWhilex(GrammarParser.WhilexContext ctx) { 
        Boolean cond = (Boolean) visit(ctx.condExpr());
        while(cond){
            visit(ctx.x);
        }
        return visit(ctx.x);
    }

    @Override
    public Object visitForex(GrammarParser.ForexContext ctx) { 
        Boolean cond = (Boolean) visit(ctx.condExpr());
        while(cond){
            cond = (Boolean) visit (ctx.condExpr());
            visit (ctx.bl);
            visit (ctx.at);
        }
        return 0d;
    }
    
    @Override
    public Object visitCondIfElse(GrammarParser.CondIfElseContext ctx) {
        Boolean cond = (Boolean) visit(ctx.condExpr());
        
        if (cond) {
            return visit(ctx.b1);
        } else {
            return visit(ctx.b2);
        }
    }


    @Override
    public Object visitCondRelOp(GrammarParser.CondRelOpContext ctx) {
        Double a = (Double) visit(ctx.expr(0));
        Double b = (Double) visit(ctx.expr(1));
        
        int op = ctx.relop.getType();
        switch (op) {
            case GrammarLexer.EQ:
                return a.equals(b);
            case GrammarLexer.LT:
                return a < b;
            case GrammarLexer.GT:
                return a > b;
            case GrammarLexer.LE:
                return a <= b;
            case GrammarLexer.GE:
                return a >= b;
        }
        return null;
    }

    @Override
    public Object visitCondExpresion(GrammarParser.CondExpresionContext ctx) {
        Double d = (Double) visit(ctx.expr());
        return d > 0;
    }

    @Override
    public Object visitWriteSTR(GrammarParser.WriteSTRContext ctx) {
        String val = ctx.STR().getText();
        System.out.println(val);
        return 0d;
    }

    @Override
    public Object visitWriteEXP(GrammarParser.WriteEXPContext ctx) {
        Object o = visit(ctx.expr());
        System.out.println(o);
        return o;
    }

    @Override
    public Object visitReadVar(GrammarParser.ReadVarContext ctx) {
        Scanner s = new Scanner(System.in);
        Object[] value = new Object[2];
        value[1] = s.nextLine();
        SymbolsTable.getInstance().addSymbol(ctx.ID().getText(), value);
        return value;
    }

    @Override
    public Object visitVarDeclaration(GrammarParser.VarDeclarationContext ctx) {
        Object[] var = new Object[2];
        var[0] = ctx.types().getText();

        SymbolsTable.getInstance().addSymbol(ctx.ID().get(0).getText(), var);
        return 0d;
    }

    @Override
    public Object visitExprPlus(GrammarParser.ExprPlusContext ctx) {
        Double a = (Double) visit(ctx.expr1());
        Double b = (Double) visit(ctx.expr());
        return a + b;
    }

    @Override
    public Object visitExprMinus(GrammarParser.ExprMinusContext ctx) {
        Double a = (Double) visit(ctx.expr1());
        Double b = (Double) visit(ctx.expr());
        return a - b;
    }

    @Override
    public Object visitExpr1Empty(GrammarParser.Expr1EmptyContext ctx) {
        return visit(ctx.expr1());
    }

    @Override
    public Object visitExpr1Mult(GrammarParser.Expr1MultContext ctx) {
        Double a = (Double) visit(ctx.expr2());
        Double b = (Double) visit(ctx.expr());
        return a * b;
    }

    @Override
    public Object visitExpr1Div(GrammarParser.Expr1DivContext ctx) {
        Double a = (Double) visit(ctx.expr2());
        Double b = (Double) visit(ctx.expr());
        return a / b;
    }

    @Override
    public Object visitExpr2Empty(GrammarParser.Expr2EmptyContext ctx) {
        return visit(ctx.expr2());
    }

    @Override
    public Object visitExpr2Par(GrammarParser.Expr2ParContext ctx) {
        return visit(ctx.expr());
    }

    @Override
    public Object visitExpr2Num(GrammarParser.Expr2NumContext ctx) {
        return Double.parseDouble(ctx.NUM().getText());
    }

    @Override
    public Object visitExpr2Id(GrammarParser.Expr2IdContext ctx) {
        return SymbolsTable.getInstance().getSymbol(ctx.ID().getText())[1];
    }
    
    @Override public Object visitAttrExpr(GrammarParser.AttrExprContext ctx) {
        Object[] lista = SymbolsTable.getInstance().getSymbol(ctx.ID().getText());
        lista[1] = visit(ctx.expr());
        return 0d;
    }
}