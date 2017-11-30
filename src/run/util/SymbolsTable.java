
package run.util;

import java.util.HashMap;


public class SymbolsTable {
    
    private HashMap<String, Object[]> symbols;
    
    protected SymbolsTable(){
        symbols = new HashMap<>();
    }
    
    private static SymbolsTable INSTANCE;
    
    public static SymbolsTable getInstance(){
        if (INSTANCE == null)
            INSTANCE = new SymbolsTable();
        return INSTANCE;
    }
    
    public void addSymbol(String symbol, Object[] value){
        symbols.put(symbol, value);
    }
    
    public Object[] getSymbol(String symbol){
        if (symbols.containsKey(symbol)){
            return symbols.get(symbol);
        }
        return null;
    }
    
}
