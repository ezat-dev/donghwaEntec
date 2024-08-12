package com.ace.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import org.eclipse.milo.opcua.sdk.client.OpcUaClient;
import org.eclipse.milo.opcua.stack.core.UaException;
import org.eclipse.milo.opcua.stack.core.types.builtin.DataValue;
import org.eclipse.milo.opcua.stack.core.types.builtin.NodeId;
import org.eclipse.milo.opcua.stack.core.types.builtin.StatusCode;
import org.eclipse.milo.opcua.stack.core.types.builtin.Variant;
import org.eclipse.milo.opcua.stack.core.types.builtin.unsigned.UShort;
import org.eclipse.milo.opcua.stack.core.types.builtin.unsigned.Unsigned;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ace.service.FurnaceService;

@Controller
public class FurnaceController {

	@Autowired
	private FurnaceService furnaceService;
	
	@RequestMapping(value = "/furnace/recipe", method = RequestMethod.GET)
	public String recipe(Model model) {
		return "/furnace/recipe.jsp";
	}
	
	@RequestMapping(value = "/furnace/recipe/plcWrite", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> recipePlcWrite(@RequestBody List<NodeValuePair> nodeValuePairs)
	        throws UaException, InterruptedException, ExecutionException {
		
	    Map<String, String> response = new HashMap<String, String>();
	    try {
	
	        UShort namespaceIndex = Unsigned.ushort(2);
	        boolean allGood = true;
	
	        int chunkSize = 50;
	        for (int i = 0; i < nodeValuePairs.size(); i += chunkSize) {
	            int end = Math.min(nodeValuePairs.size(), i + chunkSize);
	            List<NodeValuePair> chunk = nodeValuePairs.subList(i, end);
	
	            List<CompletableFuture<StatusCode>> futures = new ArrayList<CompletableFuture<StatusCode>>();
	
	            for (NodeValuePair pair : chunk) {
	                String nodeIdStr = pair.getNodeId();
	                short valueStr = pair.getValue();
	
	                NodeId nodeId = new NodeId(namespaceIndex, nodeIdStr);
	                DataValue dataValue = new DataValue(new Variant(valueStr));
	
	                futures.add(MainController.client.writeValue(nodeId, dataValue));
	            }
	
	            for (CompletableFuture<StatusCode> future : futures) {
	                StatusCode statusCode = future.get();
	                if (!statusCode.isGood()) {
	                    allGood = false;
	                    System.out.println("Failed to write value: " + statusCode);
	                }
	            }
	        }
	
	        if (allGood) {
	            response.put("status", "success");
	            response.put("message", "All values written successfully");
	        } else {
	            response.put("status", "failure");
	            response.put("message", "Some values failed to write");
	        }
	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	
	    return response;
	}	
	
	
	@RequestMapping(value = "/furnace/recipe/globalParameter", method = RequestMethod.GET)
	public String globalParameter(Model model) {
		return "/furnace/globalParameter.jsp";
	}	
	
	
	public static class NodeValuePair {
	    private String nodeId;
	    private short value;
	
	    public String getNodeId() {
	        return nodeId;
	    }
	
	    public void setNodeId(String nodeId) {
	        this.nodeId = nodeId;
	    }
	
	    public short getValue() {
	        return value;
	    }
	
	    public void setValue(short value) {
	        this.value = value;
	    }
	}
	 
}
