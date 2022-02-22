
# Run this First

Compiles the `decoderbufs` postgresql module for replication

```
make once
```

# Start Everything

```
make up
```

# Create Debezium to Kafka Connection

```
./create_connector.sh
```

# Stop Everything

```
make down
```

# Reset

```
make clean up
```

# List Kafka Topics

```
./kafka-util.sh topics
```

# Display Registered Schemas

```
./kafka-util.sh schemas
```

# Listen to a topic

```
./kafka-util.sh watch $topic
```
