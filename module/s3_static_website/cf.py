import boto3
import os
import time

def lambda_handler(event, context):
    cloudfront_dist = os.environ['distribution_id']
    
    client = boto3.client('cloudfront')
    response = client.create_invalidation(
    	DistributionId=cloudfront_dist,
    	InvalidationBatch={
    		'Paths': {
    			'Quantity': 1,
    			'Items': [
    				'/*',
    				]
    			
    		},
    		'CallerReference': str(time.time()).replace(".", "")
    		
    	}
    	)