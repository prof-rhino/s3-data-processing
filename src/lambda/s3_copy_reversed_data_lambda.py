#!/usr/bin/env python3

import os
import logging
import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

REGION = os.environ.get('REGION')
DST_BUCKET = os.environ.get('DST_BUCKET')


def handler(event, context):
    s3 = boto3.resource('s3', region_name=REGION)
    LOGGER.info('Event structure: %s', event)

    for record in event['Records']:
        src_bucket = record['s3']['bucket']['name']
        src_key = record['s3']['object']['key']

        text = s3.Object(src_bucket, src_key)
        data = text.get()['Body'].read().decode('utf-8')
        data_1 = data[::-1]

        LOGGER.info('copy_source: %s', src_key)
        s3.Object(DST_BUCKET, src_key + '-reversed').put(Body=data_1)

    return {
        'status': 'ok'
    }
